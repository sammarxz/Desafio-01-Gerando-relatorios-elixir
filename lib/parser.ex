defmodule GenReport.Parser do

  @months %{
    1 => "janeiro",
    2 => "fevereiro",
    3 => "março",
    4 => "abril",
    5 => "maio",
    6 => "junho",
    7 => "julho",
    8 => "agosto",
    9 => "setembro",
    10 => "outubro",
    11 => "novembro",
    12 => "dezembro"
  }

  def parse_file(file_name) do
    file_name
    |> File.stream!()
    |> Stream.map(&parse_line/1)
  end

  defp parse_line(line) do
    line
    |> String.trim()
    |> String.split(",")
    |> format_line()
    |> List.update_at(3, &get_month_name/1)
  end

  defp format_line([name | values]), do: [String.downcase(name) | Enum.map(values, &String.to_integer/1)]

  def get_month_name(num) when num  >= 1 and num <= map_size(@months), do: @months[num]
  def get_month_name(_num), do: "please use only integers numbers from 1 to 12"
end
