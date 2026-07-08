# Builds on the official SageMath image, which ships a tested, working
# Sage install — this avoids the GSL-version-drift problem you get from a
# bare conda `base` env accumulating unrelated packages over time.
#
# NOT build-tested in this environment (no Docker/network access available
# here) — verify `docker build .` succeeds and adjust as needed before
# relying on this for a real deployment.
FROM sagemath/sagemath:latest

USER root
WORKDIR /app

# Sage ships its own full Python distribution; install Flask into it
# rather than relying on a separate system Python, so the same
# interpreter that runs Flask also has direct access to Sage's environment
# (HOME, PYTHONPATH, etc. are already correctly set up by the image).
COPY backend/requirements.txt backend/requirements.txt
RUN sage -pip install -r backend/requirements.txt

COPY . .

# main.py invokes `sage` as a subprocess for the judge regardless of which
# interpreter is running Flask, so this should resolve on PATH inside the
# image already. Uncomment and adjust if the image puts it somewhere else:
# ENV SAGE_BINARY=/home/sage/sage/sage

EXPOSE 6767
CMD ["sage", "-python", "backend/main.py"]
