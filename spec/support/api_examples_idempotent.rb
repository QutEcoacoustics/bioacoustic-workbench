require 'spec_helper'

shared_examples :an_idempotent_api_call do |klass, many = true|

  # should test getting an non-existing record

  #let(:random_item) do
  #  offset = rand(klass.count)
  #  klass.first(:offset => offset) unless many
  #end

  it { should respond_with(:success) }

  it { should respond_with_content_type(:json) }

  it "should #{'not' unless many} be a list" do
    #@response_body.send(many ? 'should' : 'should_not', have(klass.count).items)
    if many
      @response_body.should have(klass.count).items
    else
      @response_body.should include(:id)
    end
  end

  it "should #{'not' unless many} be an array" do

    @response_body.send(many ? 'should' : 'should_not',  be_an_instance_of(Array))
  end

  it "should #{'not' unless many} be a single item" do
    @response_body.send(!many ? 'should' : 'should_not',  be_an_instance_of(Hash))
  end

  it 'should not be empty' do
    @response.body.should_not be_blank

    if klass.count == 0
      @response_body.should be_blank
    else
      @response_body.should_not be_blank
    end

  end

  unless many
    it 'should ensure json response matches initial object' do
      @response_body[:id].should == @item.id
    end
  end


  #measurement_methods.each do |measurement_method|
  #  it "should return #{measurement} from ##{measurement_method}" do
  #    subject.send(measurement_method).should == measurement
  #  end
  #end
end