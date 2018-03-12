# VCRMockHelper

Support helper to use [ExVCR](https://github.com/parroty/exvcr).

This helper has some functions below.

- Generate fixture's path.
- Generate fixture name.

## Generate fixture's path.

Generate fixture's path from the test module name.

If test module is `Sudix.FooBarTest`, fixtures will save under
`fixture/vcr_cassettes/sudix/foo_bar_test`.


## Generate fixture name.

Generate fixture name automatically by `describe` and `test` of the test.

1. Concatenate `describe` and `test` in the test's context.
2. Generate hash value from the string by MD5.
3. Add index by execution order.

### example
`e99c4a884031343a27a89e7b43d500e9419c8d8e78378d105e7a48995002615f_1.json`

# Usage

## example

```
defmodule Sudix.FooBarTest do
  use ExUnit.Case
  use VCRMockHelper

  alias Sudix.FooBar

  describe "some func" do
    test "some test", context do
      res =
        with_cassette context do
          FooBar.func()
        end

      assert {:ok, _} == res
    end
  end
end
```
