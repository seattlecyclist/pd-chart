require 'spec_helper'
require './app/services/pipeline/deals.rb'

describe Pipeline::Deals do
  subject do
    service = Pipeline::Deals.new
    VCR.use_cassette("deals") do
      service.all_deals
    end
    service
  end

  it 'finds the right number of deals' do
    expect(subject.all_deals.size).to eq 100
  end

  it 'groups the deals by stage' do
    expect(subject.by_deal_stage.keys.size).to eq 6
  end

  it 'sorts totals the stages by percent' do
    previous_percent = 0
    subject.stage_totals.each do |h|
      expect(h[:stage_percent]).to be >= previous_percent
    end
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
    expect(subject.max_total).to eq 1187818.46
  end

end