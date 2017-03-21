defmodule CreateCompanyTest do
  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  alias ExVCR.Config

  setup_all do
    Config.cassette_library_dir(
      "fixture/vcr_cassettes",
      "fixture/custom_cassettes"
    )

    Config.filter_url_params(true)
    Config.filter_request_headers("basic_auth")

    :ok
  end

  setup do
    PromisepayEx.configure(
      username: "test.test@example.com",
      password: "test",
      environment: "test",
      api_domain: "api.localhost.local:3000",
    )

    Config.filter_request_headers("Authorization")

    :ok
  end

  test "create_company returns Map (201)" do
    use_cassette "companies/post/201" do
      options = %{
        name: "Samuel's Gardening",
        legal_name: "Samuel's Gardening Pty Ltd",
        user_id: "064d6800-fff3-11e5-86aa-5e5517507c66",
        tax_number: "100200300",
        charge_tax: false,
        address_line1: "500 Garden St",
        address_line2: "",
        city: "Sydney",
        state: "NSW",
        zip: "2000",
        country: "AUS",
        phone: "+61491570156"
      }

      company = PromisepayEx.create_company(options)

      assert is_map(company)

      assert company.id
      assert company.legal_name
      assert company.related
    end
  end

  test "create_company raises error (401)" do
    use_cassette "companies/post/401" do
      try do
        PromisepayEx.create_company(%{})
      rescue
        error in [PromisepayEx.Error] ->
          %{token: ["is not authorized"]} = error.message
          assert error.code == 401
      end
    end
  end

  test "create_company raises error (422)" do
    use_cassette "companies/post/422" do
      try do
        PromisepayEx.create_company(%{})
      rescue
        error in [PromisepayEx.Error] ->
          %{user_id: ["required field missing"]} = error.message
          assert error.code == 422
      end
    end
  end
end
