FROM python

COPY ./sum.py /root/sum.py
COPY ./hello_world_server.py /root/hello_world_server.py

CMD python /root/hello_world_server.py
