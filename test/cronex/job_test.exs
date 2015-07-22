defmodule Cronex.JobTest do
  use ExSpec, async: true
  doctest Cronex.Job
  alias Cronex.Job
  use Timex

  setup do
    ref_date = Date.from({{2015, 3, 21}, {16, 12, 8}})
    {:ok, [ref_date: ref_date]}
  end

  describe "is_due?" do
    it "all defaults must always match", context do
      is_due = Job.is_due?(%Cronex.Job{s: :all, m: :all, h: :all, d: :all, mon: :all, dow: :all }, context[:ref_date])
      assert is_due
    end

    it "with only seconds, do not match if not equals", context do
      is_due = Job.is_due?(%Cronex.Job{s: 0, m: :all, h: :all, d: :all, mon: :all, dow: :all }, context[:ref_date])
      refute is_due
    end
  end
end
