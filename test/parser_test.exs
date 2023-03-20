defmodule GenReport.ParserTest do
  use ExUnit.Case

  alias GenReport.Parser

  describe "parse_file/1" do
    test "parses the file" do
      file_name = "gen_report.csv"

      response =
        file_name
        |> Parser.parse_file()
        |> Enum.member?(["daniele", 7, 29, "abril", 2018])

      assert response == true
    end
  end

  describe "get_month_name/1" do
   test "given a number, returns the proper month name" do
      response = Parser.get_month_name(5) # get the month of May

      expected_response = "maio"

      assert response == expected_response
   end 

    test "given an invalid param, returns an error message" do
      response = Parser.get_month_name("03") 

      expected_response = "please use only integers numbers from 1 to 12"

      assert response == expected_response
    end
  end
end
