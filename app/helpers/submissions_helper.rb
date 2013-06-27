module SubmissionsHelper
  def time_and_location(submission)
    text = nil
    if submission.day
      text = [ submission.day, submission.time_range.try(:downcase) ].compact * ' '
    else
      text = submission.time_range.try(:titleize)
    end
    if text.present?
      text += " at #{submission.location}" if submission.location.present?
    else
      text = "At #{submission.location}" if submission.location.present?
    end
    text
  end

  def approximate(number, round_to = 100)
    round_to = 10 if number <= 100
    approximation = (number / round_to).ceil * round_to
    approximation > 0 ? "About #{approximation}" : ''
  end

end
