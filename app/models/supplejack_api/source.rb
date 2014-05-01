module SupplejackApi
  class Source
    include Mongoid::Document

    store_in collection: 'sources', session: 'strong'
  
    attr_accessible :name, :source_id, :_id, :partner_id, :status
  
    field :name,        type: String
    field :source_id,   type: String
    field :status, 		type: String, default: 'active'
  
    belongs_to :partner, class_name: 'SupplejackApi::Partner'
  
    validates :name, presence: true
  
    scope :suppressed,  -> { where(status: 'suppressed') }
  end
end