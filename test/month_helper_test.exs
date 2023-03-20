defmodule GenReport.MonthHelperTest do
  use ExUnit.Case

  alias GenReport.MonthHelper

  describe "get_month_name/1" do
   test "given a number, returns the proper month name" do
      response = MonthHelper.get_month_name(5) # get the month of May

      expected_response = "maio"

      assert response == expected_response
   end 

    test "given an invalid param, returns an error message" do
      response = MonthHelper.get_month_name("03") 

      expected_response = "please use only integers numbers from 1 to 12"

      assert response == expected_response
    end
  end
end

