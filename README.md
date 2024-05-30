# PLAY

This project is a data science and web development playground, with some experiments on blockchain platforms. The main goal here is to learn new technologies, code insightful implementations, and share important concepts. In this way it is an ongoing work with a lot of opportunities yet to be taken and improvements to be done following two strategic approaches:

- Done is better than perfect because perfect is never done.
- Whoever does the work, does the learning.

## ARCHITECTURE

![Project Architecture](architecture.png)

We strongly value concepts (as they last longer) over tools (which are interchangeable). Each development environment or prior knowledge will result in different stack choices and that's okay. Here we favor open source tools because of their quality, community and commitment to the learning process.

- [VueJS](frontend/README.md): an approachable, performant and versatile framework for building web user interfaces.
- [Jupyter](notebook/README.md): open standards, and web services for interactive computing across all programming languages.
- [FastAPI](restapi/README.md): modern and high-performance web framework to build APIs with Python and standard type hints.
- [Spark](engine/README.md): multi-language engine for executing data engineering/science, and machine learning on clusters.
- [Airflow](workflow/README.md): platform created by the community to programmatically author, schedule and monitor workflows.
- [MinIO](storage/README.md): high-performance, S3 compatible object store, built for large scale AI/ML warehouse workloads.
- [PostgreSQL](database/README.md): object-relational database with a strong reputation for reliability, robustness, and performance.
- [Kafka](stream/README.md): distributed event streaming system for high-performance data pipelines, analytics and data integration.
- [Alchemy or Infura](blockchain/README.md): powerful APIs, SDKs, and tools for seamless Web3 development and scale apps with ease.
- [Kubernetes](platform/README.md): platform for automating deployment, scaling, and management of containerized applications.

## STRUCTURE

| APPLICATION | DATA SCIENCE | INFRASTRUTURE |
| :---------: | :----------: | :-----------: |
| frontend    | notebook     | platform      |
| backend     | engine       | blockchain    |
| database    | datalake     |               |
| stream      | workflow     |               |