defmodule GenReport do

  alias GenReport.Parser

  def build, do: {:error, "Insira o nome de um arquivo"}
  def build (filename) do
    list = Parser.parse_file(filename)
    list
    |> Enum.reduce(
      report_acc(list),
      fn line, report -> sum_values(line, report) end
    )
  end

  defp report_acc(list) do
    possibilities = get_unique_possibilities(list)

    available_names = possibilities["available_names"]
    available_months = possibilities["available_months"]
    available_years = possibilities["available_years"]

    hours = Enum.into(available_names, %{}, &{&1, 0})
    months = Enum.into(available_months, %{}, &{&1, 0})
    years = Enum.into(available_years, %{}, &{&1, 0})

    build_report(
      hours,
      Enum.into(available_names, %{}, &{&1, months}),
      Enum.into(available_names, %{}, &{&1, years})
    )
  end

  defp sum_values([name, hour, _day, month, year], %{ "all_hours" => hours, "hours_per_month" => months, "hours_per_year" => years}) do
    hours = Map.put(hours, name, hours[name] + hour)
    months_per_user = Map.put(months[name], month, months[name][month] + hour)
    years_per_user = Map.put(years[name], year, years[name][year] + hour)

    months = Map.put(months, name, months_per_user)
    years = Map.put(years, name, years_per_user)

    build_report(hours, months, years)
  end

  defp build_report(hours, months, years),
    do: %{
      "all_hours" => hours,
      "hours_per_month" => months,
      "hours_per_year" => years
    }

  defp get_unique_possibilities(list) do
    unique_names = get_unique(list, 0)
    unique_months = get_unique(list, 3)
    unique_years = get_unique(list, 4)

    %{
      "available_names" => unique_names,
      "available_months" => unique_months,
      "available_years" => unique_years
    }
  end

  defp get_unique(list, index) do
    list
    |> Enum.map(&Enum.at(&1, index))
    |> Enum.uniq()
  end
end
