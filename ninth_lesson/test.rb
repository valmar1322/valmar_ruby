# frozen_string_literal: true

a = [3, 5, 7, 2]

puts '123' if a.any?(&:even?)
