class SoundLog < ActiveRecord::Base
  belongs_to :user
  belongs_to :sound

  after_create :enqueue_job

  private

  def enqueue_job?
    # TODO: ジョブをキューに入れるかどうかの判定のみを行うメソッド
    # したがって、返り値は必ずbooleanで!!
  end
end
