require 'spec_helper'
require './app/services/pipeline/deals.rb'

describe Pipeline::Deals do
  subject do
    VCR.use_cassette("deals") do
      Pipeline::Deals.new
    end
  end


  it 'finds the right number of deals' do
    expect(subject.all.size).to eq 100
  end

  it 'groups the deals by stage' do
    expect(subject.by_deal_stage.keys.size).to eq 6
  end

  it 'returns the expected groups' do
    expect(subject.stage_totals.map{|s| s[:stage]}).to include("Lost",
                                                               "Qualified",
                                                               "Request for Info",
                                                               "Presentation",
                                                               "Negotiation",
                                                               "Won")
  end


  it 'returns the expected max total' do
    expect(subject.max).to eq 1187818.46
  end

end