# frozen_string_literal: true

class Grs
  def self.version
    '1.0.1'.to_s
  end
end

begin
    Grs.version
rescue StandardError => e
    puts e.backtrace
ensure
    GC.auto_compact
end

__END__