atom_feed do |feed|
  feed.title('Denver Startup Week Events')
  # feed.updated(@submissions.max(:created_at)) if @submissions.length > 0
  @submissions.each do |submission|
    feed.entry(submission) do |entry|
      entry.title(submission.title)
      entry.content(submission.description, type: 'html')
      entry.author do |author|
        author.name(submission.submitter.name)
      end
    end
  end
end
