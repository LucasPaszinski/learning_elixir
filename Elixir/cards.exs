ranks = ["2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K", "A"]
suits = ["♦", "♠", "♣", "♥"]

deck = for rank <- ranks, suit <- suits, do: ["#{suit} #{rank}"]

IO.puts "\n"
deck
|> Enum.shuffle()
|> Enum.take(20)
|> Enum.join(" | ")
|> IO.puts()
IO.puts "\n"


