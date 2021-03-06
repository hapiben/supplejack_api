# frozen_string_literal: true
# The majority of the Supplejack API code is Crown copyright (C) 2014, New Zealand Government,
# and is licensed under the GNU General Public License, version 3.
# One component is a third party component. See https://github.com/DigitalNZ/supplejack_api for details.
#
# Supplejack was created by DigitalNZ at the National Library of NZ and
# the Department of Internal Affairs. http://digitalnz.org/supplejack

require 'resque/tasks'
require 'resque_scheduler/tasks'

namespace :resque do
  task setup: :environment do
    require 'resque'
    require 'resque_scheduler'
    require 'resque/scheduler'

    # The schedule doesn't need to be stored in a YAML, it just needs to
    # be a hash.  YAML is usually the easiest.
    Resque.schedule = YAML.load_file(File.join(Rails.root.to_s, 'config/resque_schedule.yml'))
  end
end
