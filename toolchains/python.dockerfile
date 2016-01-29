FROM zalando/python:3.5.0-4

RUN apt-get update && apt-get install -y build-essential libxml2-dev libxslt-dev zlib1g-dev

# install Python "wheel" to upload "binary" wheel packages to PyPI
# (python3 setup.py bdist_wheel)
RUN pip3 install --upgrade pip wheel virtualenv flake8

COPY switch-user.sh /switch-user.sh
ENTRYPOINT ["/switch-user.sh"]
