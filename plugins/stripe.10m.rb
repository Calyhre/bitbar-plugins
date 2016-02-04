#!/usr/bin/env rbenv-ruby

require 'dotenv'
require 'stripe'

Dotenv.load(File.join __dir__, '../.env')

Stripe.api_key = ENV['STRIPE_API_KEY']

balance   = Stripe::Balance.retrieve
available = balance['available'][0]['amount']
pending   = balance['pending'][0]['amount']
total     = (available + pending) / 100.0

puts "💰#{total}€"
