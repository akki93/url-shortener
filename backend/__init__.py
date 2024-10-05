from .app import create_app
from .rate_limiter import setup_rate_limiter

app = create_app()
limiter = setup_rate_limiter(app)
