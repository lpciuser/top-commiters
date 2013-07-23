shared_examples "a github API object" do 
  
  it "should respond to hash" do
    expect(object.respond_to?(:hash)).to be_true
  end

  it "should provide method-like access to contained hash" do
    object.hash.each do |k, val|
      expect(object.send(k)).to eq(val)
    end
  end

  it "should lazy-load contained hash" do
    expect(object).not_to be_loaded
    object.hash
    expect(object).to be_loaded
  end
end