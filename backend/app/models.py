from sqlalchemy import Column, Integer, String, Date
from app.database import Base

class Book(Base):
    __tablename__ = "books"

    id = Column(Integer, primary_key=True, index=True)
    title = Column(String(255), index=True) 
    author = Column(String(255), index=True) 
    genre = Column(String(255), index=True) 
    published_date = Column(Date)
    description = Column(String(1000)) 
