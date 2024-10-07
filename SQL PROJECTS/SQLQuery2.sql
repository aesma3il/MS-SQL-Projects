alter table tb_book
add constraint fk_author foreign key(Author) references tb_author(AuthorID);


alter table tb_book
alter column Author int;