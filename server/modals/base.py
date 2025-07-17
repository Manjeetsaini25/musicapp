from sqlalchemy import Column, Text, VARCHAR, LargeBinary
from sqlalchemy.orm import declarative_base
from sqlalchemy.orm import relationship

Base = declarative_base()

class User(Base):
    __tablename__= 'users'
    
    id = Column(Text, primary_key=True)
    name = Column(VARCHAR(100))
    email = Column(VARCHAR(100), unique=True)
    password = Column(LargeBinary)
    
    favorites = relationship('Favorite', back_populates='user')