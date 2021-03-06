class Note < ActiveRecord::Base
  paginates_per NOTE_PER_PAGE

  belongs_to :category
  belongs_to :group
  belongs_to :author, class_name: "User"
  belongs_to :last_editor, class_name: "User"
  has_many :attachments

  validates :text, :group, :author, presence: true

  default_scope { order('created_at DESC') }

  # Create a note and add existing attachments with
  # attachment_ids to it when they exist
  def self.create_with_attachments(user, params)
    note = Note.new(group_id: user.group_id,
                    text: params[:text],
                    category_id: params[:category_id],
                    author: user)
    begin
      Note.transaction do
        note.save!
        attachments = Attachment.find(params[:attachment_ids])
        attachments.each do |attachment|
          attachment.update_attributes(note: note)
        end
      end
    rescue
      nil
    end
    note
  end
end
