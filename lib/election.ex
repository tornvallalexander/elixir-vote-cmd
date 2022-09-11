defmodule Election do
  defstruct(
    name: "Mayor",
    candidates: [
      Candidate.new(1, "Will Ferrell",
      Candidate.new(2, "Kristen Wiig",
    ],
    next_id: 3
  )

  def view_header(election) do
    [
      "Election for #{election.name}\n",
    ]
  end
end

