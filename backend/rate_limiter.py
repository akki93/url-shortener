from flask_limiter import Limiter
from flask_limiter.util import get_remote_address

def setup_rate_limiter(app):
    limiter = Limiter(
        get_remote_address,
        app=app,
        default_limits=["200 per day"]  # Set limits as necessary
    )
    return limiter