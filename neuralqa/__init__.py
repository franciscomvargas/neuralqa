import logging
from version import VERSION as __version__
from reader import BERTReader
from utils import import_sample_data


logging.getLogger("transformers").setLevel(logging.ERROR)
logging.getLogger("tensorflow").setLevel(logging.ERROR)
logging.getLogger("elasticsearch").setLevel(logging.CRITICAL)

__all__ = ["BERTReader", "import_sample_data"]
