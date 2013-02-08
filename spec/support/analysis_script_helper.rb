require 'spec_helper'
require 'uuidtools'

module Shared
  def self.shared_properties
    {
        display_name: ':-) My awesome/brilliant analysis!!',
        name:         '____my_awesome_brilliant_analysis__',

        extra_data:   ({ aTestSetting: 3.0, someSubSettings: { subSettingOne: 'A configuration!', subSettingTwo: 2 } }),
        settings:     './cache/media/analysis_scripts/____my_awesome_brilliant_analysis__/settings.ini',

        description:  Faker::Lorem.paragraphs(2),
        version:      '3.0',
    }
  end

  def check_search_data_set_item(item, attributes = {})
    item.id.should be_a_kind_of(Fixnum)
    item.id.should_not be_blank
    if attributes.include?(:id)
      attributes[:id].should include(item.id)
    end

    item.uuid.should be_a_kind_of(String)
    item.uuid.should_not be_blank

    expect { UUIDTools::UUID.parse(item.uuid) }.to_not raise_error
    if attributes.include?(:uuid)
      attributes[:uuid].should include(item.uuid)
    end

    #TODO offsets
  end
end
