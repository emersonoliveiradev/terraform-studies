import logging
import os

logger = logging.getLogger("init")
logging.basicConfig(
    level=logging.INFO,
    format="%(asctime)s - %(name)s - %(levelname)s - %(message)s"
)


def get_environments(keys):
    return list(map(lambda key: os.getenv(key, f"{key} not found!"), keys))


if __name__ == "__main__":
    logger.info("Starting...")
    keys = [
        "APP_ENV",
        "APP_NAME",
        "AWS_REGION",
        "APP_USER",
        "APP_PASSWORD",
        "BETTER_THAN_INTERSTELLAR_MOVIE"
    ]

    logger.info(f"Environments: {get_environments(keys)}")
    logger.info("Stopping...")
