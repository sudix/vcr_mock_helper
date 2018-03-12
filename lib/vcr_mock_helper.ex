defmodule VCRMockHelper do
  @moduledoc File.read!("#{__DIR__}/../README.md")

  defmacro __using__(_opts) do
    quote do
      use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

      import VCRMockHelper

      @exvcr_options Application.get_env(:vcr_mock_helper, :exvcr_options)
      @fixture_base_dir "fixture/vcr_cassettes"

      setup_all do
        fixture_path = gen_fixture_path()
        ExVCR.Config.cassette_library_dir(fixture_path)
        counter = init_counter()
        on_exit(fn -> unload_vcr() end)
        {:ok, counter: counter}
      end

      defp gen_casette_id(%{describe: desc, test: test} = _context) do
        {:ok, to_md5("#{desc}#{test}")}
      end

      defp to_md5(str) do
        :crypto.hash(:sha256, str) |> Base.encode16(case: :lower)
      end

      defp gen_fixture_path() do
        test_path = __MODULE__ |> Macro.underscore()
        Path.join(@fixture_base_dir, test_path)
      end

      defp init_counter() do
        :ets.new(:counter, [:public])
      end

      defp increment_counter(counter, cassette_id) do
        :ets.update_counter(counter, cassette_id, 1, {1, 0})
      end
    end
  end

  defmacro with_cassette(context, do: block) do
    quote do
      {:ok, cassette_id} = gen_casette_id(unquote(context))
      counter = unquote(context)[:counter]

      idx = increment_counter(counter, cassette_id)

      use_cassette "#{cassette_id}_#{idx}", @exvcr_options do
        unquote(block)
      end
    end
  end
end
