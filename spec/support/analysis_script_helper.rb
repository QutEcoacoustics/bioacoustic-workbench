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
end
