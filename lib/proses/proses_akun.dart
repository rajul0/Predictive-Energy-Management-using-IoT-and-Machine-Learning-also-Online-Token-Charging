Future<void> addUserData(
    auth, storage, db, idUser, namaLengkap, email, password, jenisAkun) async {
  return db.collection('user_data').doc().set({
    'id_user': idUser,
    'full_name': namaLengkap,
    'email': email,
    'password': password,
    'account_type': jenisAkun
  }).catchError((error) => print("Failed to add user: $error"));
}
