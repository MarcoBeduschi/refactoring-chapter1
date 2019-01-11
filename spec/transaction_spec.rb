require_relative '../transaction'

describe 'transaction' do
  let(:invoice) do
    {
      'customer': 'BigCo',
      'performances': [
        {
          'play_ID': 'hamlet',
          'audience': 55
        },
        {
          'play_ID': 'aslike',
          'audience': 35
        },
        {
          'play_ID': 'othello',
          'audience': 40
        }
      ]
    }
  end

  let(:expected_statement) do
    "Statement for BigCo\nHamlet: $650.00 (55 seats)\nAs You Like It: $580.00 (35 seats)\nOthello: $500.00 (40 seats)\nAmount owed is $1730.00\nYou earned 43 credits"
  end

  subject { Transaction.new(invoice) }

  it 'should return true' do
    expect(subject.statement).to eq expected_statement
  end
end
