FROM ubuntu:18.04

USER root

# R pre-requisites
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    fonts-dejavu \
    tzdata \
    gfortran \
    default-jdk \
    default-jdk-headless \
    libudunits2-0 \
    libudunits2-dev \
    gnupg \
    r-base \
    gdebi-core \
    python-rpy2 \
    python3-rpy2 \
    libssl-dev \
    libgdal-dev \
    libssh2-1 \
    libssh2-1-dev \
    libgit2-26 \
    libgit2-dev \
    libunwind-dev \
    libzmq3-dev \
    libcairo2-dev \
    libopenblas-base \
    libopenblas-dev \
    gcc \
    build-essential \
    apt-utils \
    ipython \
    python3-notebook \
    jupyter-core \
    python-ipykernel \  
    software-properties-common && \
    apt-get autoremove -y && \
    apt-get clean all
     
#RUN pip install jupyter

RUN jupyter notebook --allow-root

RUN echo "install.packages('devtools',repos='https://cloud.r-project.org');"  > /tmp/install.R && \
    echo "install.packages(c('restatapi','eurostat','rdbnomics','TSsdmx','ggrepel','ggraph','ggiraph','ggnetwork','ggTimeSeries','plotrix','tmap','rjson','rsdmx','leaflet','shinyjs','TSdbi','timeSeries','RJDemetra','flagr','ggdemetra'),repos='https://cloud.r-project.org')" >> /tmp/install.R && \ 
#    echo "update.packages" >> /tmp/install.R && \
    echo "devtools::install_github('IRkernel/IRkernel');" >> /tmp/install.R && \
    Rscript /tmp/install.R
    

USER $NB_UID

RUN echo "IRkernel::installspec();" > install.R && \
    Rscript install.R
 
# RUN wget https://raw.githubusercontent.com/eurostat/statistics-coded.git/master/popul/young-people-social-inclusion_R.ipynb 
   
# RUN git clone https://github.com/eurostat/statistics-coded.git
