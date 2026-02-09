from __future__ import annotations

import os

from fastapi import FastAPI

app = FastAPI()


@app.get("/")
def hello_it() -> dict[str, str]:
	return {"message": "hello it"}


def _get_port() -> int:
	return int(os.getenv("IT_SERVER_PORT", "6002"))


if __name__ == "__main__":
	import uvicorn

	uvicorn.run("app:app", host="0.0.0.0", port=_get_port(), reload=False)
