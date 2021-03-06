FROM python:3.9

# Run python in unbuffered mode to allow for log messages to be
# immediately dumped to the stream instead of being buffered.
ENV PYTHONUNBUFFERED 1

# Install Python and system dependencies
RUN pip install --upgrade pip \
    && pip install --upgrade setuptools \
    && pip install --upgrade pipenv
RUN apt-get update \
    && apt-get install -y --no-install-recommends gettext

# Copy the Pipenv files into the container
COPY Pipfile* /tmp/

# Install the dependencies system-wide
WORKDIR /tmp
RUN pipenv sync --dev --system

# Create mount point for docker-compose volume and set as current workdir
WORKDIR /legaldb

#Creating a user
RUN useradd -ms /bin/bash user
USER user
