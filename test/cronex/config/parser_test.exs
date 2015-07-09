defmodule Cronex.Config.ParserTest do
  use ExSpec, async: true
  alias Cronex.Config.Parser
  doctest Cronex.Config.Parser

  setup do
    content = """
    # The newline at the end of this file is extremely important.  Cron won't run without it.
    # command 1
    #0,30 * * * * root test

    # command 2
    0 19 * * * root test 2
    """
    {:ok, [content: content]}
  end

  describe "split lines" do
    it "split a file in lines", context do
      lines = Parser.split_lines(context[:content])
      assert length(lines) == 5
    end
  end

  describe "strip comments" do
    it "removes the comment lines", context do
      lines = context[:content]
      |> Parser.split_lines
      |> Parser.strip_comment_lines
      assert length(lines) == 1
    end
  end
end
