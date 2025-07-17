from fastapi import FastAPI
from routes import auth, song
import database as dtb
from modals import  base

app = FastAPI()
Base = base.Base

app.include_router(auth.router, prefix='/auth')
app.include_router(song.router, prefix='/song')

Base.metadata.create_all(dtb.engine)
