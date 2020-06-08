defmodule TableFormater do
  def print_table_for_columns(rows, headers) do
    with data_by_columns = split_into_columns(rows, headers),
         columns_widths = widths_of(data_by_columns, headers),
         format = format_for(columns_widths) do
      puts_one_line_in_columns(headers, format)
      IO.puts(separator(columns_widths))
      puts_in_columns(data_by_columns, format)
    end
  end

  def split_into_columns(rows, headers) do
    for header <- headers do
      for row <- rows do
        printable(row[header])
      end
    end
  end

  def printable(str) when is_binary(str), do: str
  def printable(str), do: to_string(str)

  def widths_of(columns) do
    for column <- columns, do: column |> Enum.map(&String.length(&1)) |> Enum.max()
  end
  def widths_of(columns, headers) do
    list1 = for column <- columns, do: column |> Enum.map(&String.length(&1)) |> Enum.max()
    list2 = for head <- (for head <- headers, into: [], do: [head]), do: head |> Enum.map(&String.length(&1)) |> Enum.max()
    higher_widths_of(list1, list2)
  end

  defp higher_widths_of([head1 | tail1], [head2 | tail2])
       when length(tail1) == length(tail2) and
              head1 >= head2 do
    [head1] ++ higher_widths_of(tail1, tail2)
  end

  defp higher_widths_of([head1 | tail1], [head2 | tail2])
       when length(tail1) == length(tail2) and
              head1 < head2 do
    [head2] ++ higher_widths_of(tail1, tail2)
  end

  defp higher_widths_of([], []) do
    []
  end

  defp higher_widths_of([], _) do
    raise "Was not the same size"
  end

  defp higher_widths_of(_, []) do
    raise "Was not the same size "
  end

  def format_for(columns_widths) do
    Enum.map_join(columns_widths, " | ", fn width -> "~#{width}s" end) <> "~n"
  end

  def separator(columns_widths) do
    Enum.map_join(columns_widths, "-+-", fn width -> List.duplicate("-", width) end)
  end

  def puts_in_columns(data_by_columns, format) do
    data_by_columns
    |> List.zip()
    |> Enum.map(&Tuple.to_list(&1))
    |> Enum.each(&puts_one_line_in_columns(&1, format))
  end

  def puts_one_line_in_columns(fields, format) do
    :io.format(format, fields)
  end
end
