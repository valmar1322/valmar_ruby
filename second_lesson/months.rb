months = {
  january: 31, february: 28, march: 31,
  may: 30, april: 31, june: 30,
  july: 31, august: 31, september: 30,
  october: 31, november: 30, december: 31
}

months.each { |month, days| puts month if days == 30 }
