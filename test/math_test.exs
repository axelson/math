defmodule MathTest do
  use ExUnit.Case, async: true
  import Math
  doctest Math

  test "nearly equal" do
    assert 0 <~> 0 == true
    assert 1 <~> 1.0 == true
    assert -1 <~> -1.0 == true
    assert 0.1+0.2 <~> 0.3 == true

    assert 0 <~> 1 == false
    assert 1 <~> 0 == false
    assert -1 <~> 1 == false
    assert 1.0 <~> 2.0 == false
    assert 1.0 <~> 1.1 == false
  end

  test "sin" do
    assert sin(0) <~> 0
    assert sin(pi/2) <~> 1
    assert sin(pi) <~> 0
  end

  test "cos" do
    assert cos(0) <~> 1
    assert cos(pi/2) <~> 0
    assert cos(pi) <~> -1
  end

  test "tan" do
    assert tan(0) <~> 0
    # FIXME elixir can't handle infinity
    # assert tan(pi/2) <~> :infinity
    assert tan(pi) <~> 0
  end

  test "asin" do
    assert asin(0) <~> 0
    assert asin(1) <~> pi/2
  end

  test "acos" do
    assert acos(0) <~> pi/2
    assert acos(1) <~> 0
  end

  test "atan" do
    assert atan(0) <~> 0
    assert atan(1) <~> pi/4
  end

  test "atan2" do
    assert atan2(0, 1) <~> 0
    assert atan2(1, 0) <~> pi/2
    assert atan2(1, 1) <~> pi/4
  end

  test "sinh" do
    assert sinh(0) <~> 0
    assert sinh(log(2)) <~> 3/4
    assert sinh(log(8)) <~> 63/16
  end

  test "cosh" do
    assert cosh(0) <~> 1
    assert cosh(log(2)) <~> 5/4
    assert cosh(log(8)) <~> 65/16
  end

  test "tanh" do
    assert tanh(0) <~> 0
    assert tanh(log(2)) <~> 3/5
    assert tanh(log(8)) <~> 63/65
  end

  test "asinh" do
    assert asinh(0) <~> 0
    # not even going to pretend I know what else asinh should do
  end

  test "acosh" do
    assert acosh(1) <~> 0
    # not even going to pretend I know what else acosh should do
  end

  test "atanh" do
    assert atanh(0) <~> 0
    # not even going to pretend I know what else atanh should do
  end

  test "exp" do
    assert exp(0) <~> 1
    assert exp(1) <~> e
    assert exp(log(2)) <~> 2
  end

  test "log" do
    assert log(1) <~> 0
    assert log(e) <~> 1
    assert log(exp(2)) <~> 2
  end

  test "log2" do
    assert log2(1) <~> 0
    assert log2(2) <~> 1
    assert log2(8) <~> 3
  end

  test "log10" do
    assert log10(1) <~> 0
    assert log10(10) <~> 1
    assert log10(100) <~> 2
  end

  test "pow" do
    # Integer powers
    assert pow(2, 2) == 4
    assert pow(2, 3) == 8
    assert pow(3, 3) == 27
    assert pow(2, 60) == 1152921504606846976
    assert pow(256, 8) == 18446744073709551616

    # Negative integer powers
    assert pow(2, -2) <~> 0.25
    assert pow(2, -2) <~> 0.25
    assert pow(10, -8) <~> 1.0e-8

    # Floating point
    assert pow(2, 2.0) <~> 4.0
    assert pow(2.0, 3) <~> 8.0

    # Floating point powers with decimals
    assert pow(2, (1/2) ) <~> sqrt(2)
    assert pow(1000, (1/4) ) <~> sqrt(sqrt(1000))
    assert pow(1000, (1/4) ) <~> sqrt(sqrt(1000))

  end

  test "sqrt" do
    assert sqrt(1) <~> 1
    assert sqrt(4) <~> 2
    Enum.each(1..10, fn(x) ->
      assert sqrt(pow(x, 2)) <~> x
    end)
  end

  test "isqrt" do
    assert isqrt(0) == 0
    assert isqrt(1) == 1
    assert isqrt(9) == 3
    assert isqrt(10) == 3
    assert isqrt(100) == 10
    assert isqrt(65535) == 255
    assert isqrt(65536) == 256
    assert isqrt(15241578780673678546105778281054720515622620750190521) == 123456789123456789123456789
    assert_raise ArithmeticError, fn -> isqrt(-2) end
  end
end
