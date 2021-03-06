# The majority of the Supplejack API code is Crown copyright (C) 2014, New Zealand Government,
# and is licensed under the GNU General Public License, version 3.
# One component is a third party component. See https://github.com/DigitalNZ/supplejack_api for details.
#
# Supplejack was created by DigitalNZ at the National Library of NZ and
# the Department of Internal Affairs. http://digitalnz.org/supplejack

require 'spec_helper'

module SupplejackApi
  describe StatusController, type: :controller do
    routes { SupplejackApi::Engine.routes }

    let(:logger) { double(:logger).as_null_object }

    before do
      allow(Support::StatusLogger).to receive(:logger) { logger }
    end

    describe "GET 'status'" do
      it "returns a '200' HTTP status if both Solr and Mongo are up and running" do
        allow(controller).to receive(:solr_up?).and_return(true)
        allow(controller).to receive(:mongod_up?).and_return(true)

        get :show
        expect(response.status).to eq 200
      end

      it "returns a '500' HTTP response if Solr is down" do
        allow(controller).to receive(:solr_up?).and_return(false)
        allow(controller).to receive(:mongod_up?).and_return(true)

        get :show
        expect(response.status).to eq 500
      end

      it "returns a '500' http response if Mongo is down" do
        allow(controller).to receive(:solr_up?).and_return(true)
        allow(controller).to receive(:mongod_up?).and_return(false)

        get :show
        expect(response.status).to eq 500
      end

      it "logs an error message when the status call takes a long time" do
        allow(controller).to receive(:solr_up?).and_raise(Timeout::Error)

        expect(logger).to receive(:error)
        get :show
      end
    end

    describe "#solr_up?" do
      it "returns true when solr is up and running" do
        ok_xml_string = <<-EOF
          <?xml version="1.0" encoding="UTF-8"?>
          <response>
            <str name="status">OK</str>
          </response>
        EOF

        allow(RestClient).to receive(:get) { ok_xml_string }

        expect(controller.send(:solr_up?)).to be_truthy
      end

      it "returns false when solr is running but failing" do
        failed_xml_string = <<-EOF
          <?xml version="1.0" encoding="UTF-8"?>
          <response>
            <str name="status">NOK</str>
          </response>
        EOF
        allow(RestClient).to receive(:get) { failed_xml_string }

        expect(controller.send(:solr_up?)).to be_falsey
      end

      context "solr is down" do
        before(:each) do
          allow(RestClient).to receive(:get).and_raise(StandardError)
        end

        it "returns false" do
          expect(controller.send(:solr_up?)).to be_falsey
        end

        it "should log an error" do
          expect(logger).to receive(:error)
          controller.send(:solr_up?)
        end
      end
    end

    describe "#mongod_up?" do
      it "returns true when mongod is up and running" do
        allow(Record).to receive_message_chain(:collection, :database, :session).and_return(session)
        expect(session).to receive(:command).with(ping: 1).and_return({"ok" => 1})

        expect(controller.send(:mongod_up?)).to be_truthy
      end

      context "mongod is down" do
        before(:each) do
          allow(Record).to receive_message_chain(:collection, :database, :session).and_return(session)
          expect(session).to receive(:command).with(ping: 1).and_return(nil)
        end

        it "returns false" do
          expect(controller.send(:mongod_up?)).to be_falsey
        end

        it "should log an error" do
          expect(logger).to receive(:error)
          controller.send(:mongod_up?)
        end
      end
    end
  end
end
