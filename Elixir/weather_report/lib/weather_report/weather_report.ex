defmodule WeatherReport do
  @moduledoc """
  Documentation for `WeatherReport`.
  """

  alias TableFormater, as: TF

  def main(argsv) do
    argsv
  end

  def all() do
    files = ["KHBR", "KCON", "BWSF1", "KIAH", "CWJR"]
    all_data = for file <- files, do: fetch_data(file)
    TF.print_table_for_columns(all_data,["location", "station_id", "temp_c"])
  end

  def fetch_data(airport_id) do
    HTTPoison.get!("https://w1.weather.gov/xml/current_obs/#{airport_id}.xml")
    |> handle_data
    |> clean_data()
  end

  def handle_data(%{status_code: 200, body: body}) do
    body
  end

  def handle_data(%{status_code: _}) do
    "Error while fetching data"
  end

  def clean_data(data) when is_binary(data) do
    data
    |> String.replace(~r/\r|\n|\t/, "")
    |> get_all_info(["location","station_id","temp_c"])
  end

  def clean_data(data), do: IO.puts data

  def get_all_info(data, [head|tail]) do
    Map.merge(get_info(data,head), get_all_info(data, tail))
  end

  def get_all_info(_data,[]) do
    %{}
  end

  def get_info(data, search_xml_key) when is_binary(search_xml_key) do
    value = Regex.named_captures(~r/<#{search_xml_key}>(?<#{search_xml_key}>.*)<.#{search_xml_key}>/, data)
    if(value != nil) do
      value
    else
      %{}
    end
  end
end



