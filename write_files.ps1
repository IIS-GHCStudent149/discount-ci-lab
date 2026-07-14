Set-Location 'C:\Users\Administrator\Documents\AIForTestingLearning\lab6-CICD'

@'
def calculate_discounted_price(price, customer_type, coupon_code=None,
                                is_holiday=False):
    """Return the discounted price for a customer purchase."""
    if price < 0:
        raise ValueError("price must be non-negative")

    if customer_type == "regular":
        discount = 0.0
    elif customer_type == "vip":
        discount = 0.10
    elif customer_type == "employee":
        discount = 0.20
    else:
        raise ValueError("unsupported customer type")

    if coupon_code == "SAVE10":
        discount += 0.10
    elif coupon_code == "SAVE20":
        discount += 0.20

    if is_holiday:
        discount += 0.05

    discount = min(discount, 0.50)
    return round(price * (1 - discount), 2)
'@ | Set-Content -Path 'discount.py' -Encoding utf8

@'
import pytest

from discount import calculate_discounted_price


def test_regular_customer_no_discount():
    assert calculate_discounted_price(100, "regular") == 100.0


def test_vip_customer_gets_discount():
    assert calculate_discounted_price(100, "vip") == 90.0


def test_employee_customer_gets_bigger_discount():
    assert calculate_discounted_price(100, "employee") == 80.0


def test_coupon_reduces_price_more():
    assert calculate_discounted_price(100, "regular", "SAVE10") == 90.0


def test_holiday_discount_is_applied():
    assert calculate_discounted_price(100, "regular", is_holiday=True) == 95.0


def test_discount_caps_at_fifty_percent():
    assert calculate_discounted_price(100, "vip", "SAVE20", is_holiday=True) == 50.0


def test_negative_price_raises_value_error():
    with pytest.raises(ValueError):
        calculate_discounted_price(-10, "regular")


def test_unknown_customer_type_raises_value_error():
    with pytest.raises(ValueError):
        calculate_discounted_price(100, "unknown")
'@ | Set-Content -Path 'test_discount.py' -Encoding utf8

@'
pytest
pytest-cov
flake8
'@ | Set-Content -Path 'requirements.txt' -Encoding utf8
