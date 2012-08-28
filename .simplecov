module SimpleCov::Configuration
  def clean_filters
    @filters = []
  end
end

SimpleCov.configure do
  clean_filters
  load_adapter 'test_frameworks'
  add_filter 'gems'
  add_filter '.rvm'
end

SimpleCov.start 'rails' do
  # any custom configs like groups and filters can be here at a central place
end
