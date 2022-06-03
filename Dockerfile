FROM amazonlinux:2.0.20200722.0
LABEL MAINTAINER Bits Lovers <contact@bitslovers.com>

ENV TERRAFORM_VERSION 0.14.11
ENV AWSCLI_VERSION 1.19.52
ENV AWS_REGION us-east-1

# Run update and install dependencies
RUN yum update -y && \
    yum install -y sudo jq python3 py-pip unzip git openssl

RUN pip3 install --upgrade pip setuptools awscli==${AWSCLI_VERSION}
ADD https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip /usr/bin/


RUN mv /usr/local/bin/aws /usr/bin/
RUN chmod +x /usr/bin/aws
RUN unzip /usr/bin/terraform_${TERRAFORM_VERSION}_linux_amd64.zip -d /usr/bin && \
    rm -f /usr/bin/terraform_${TERRAFORM_VERSION}_linux_amd64.zip

RUN aws configure set region ${AWS_REGION}

RUN terraform --version && \
    aws --version
