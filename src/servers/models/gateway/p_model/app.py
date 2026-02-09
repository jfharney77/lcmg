from __future__ import annotations

import os

from fastapi import FastAPI

app = FastAPI()


@app.get("/")
def hello_p() -> dict[str, str]:
	return {"message": "hello p"}


def _get_port() -> int:
	return int(os.getenv("P_SERVER_PORT", "6001"))


if __name__ == "__main__":
	import uvicorn

	uvicorn.run("app:app", host="0.0.0.0", port=_get_port(), reload=False)
