def calculate_discounted_price(price, customer_type, coupon_code=None, is_holiday=False):

    if price < 0:

        raise ValueError("price cannot be negative")

    customer_type = customer_type.lower()

    if customer_type == "premium":

        price = price * 0.8

    elif customer_type == "standard":

        price = price * 0.9

    if coupon_code == "SAVE10":

        price = price * 0.9

    elif coupon_code == "SAVE20" and customer_type == "premium":

        price = price * 0.8

    if is_holiday:

        price = price * 0.95

    return round(price, 2)

SUPPORTED_COUPON_CODES = {"SAVE10": "10% off for all customers", "SAVE20": "20% off exclusively for premium customers"}