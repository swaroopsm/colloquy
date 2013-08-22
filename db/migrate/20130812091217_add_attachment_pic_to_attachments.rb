class AddAttachmentPicToAttachments < ActiveRecord::Migration
  def self.up
    change_table :attachments do |t|
      t.attachment :pic
    end
  end

  def self.down
    drop_attached_file :attachments, :pic
  end
end
