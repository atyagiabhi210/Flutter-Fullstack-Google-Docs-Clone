import 'package:docs_clone/colors.dart';
import 'package:docs_clone/common/widgets/loadet.dart';
import 'package:docs_clone/models/document_model.dart';
import 'package:docs_clone/repository/auth_repository.dart';
import 'package:docs_clone/repository/document_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  void signOut(WidgetRef ref) {
    ref.read(authRepositoryProvider).signOut();
    ref.read(userProvider.notifier).update((state) => null);
  }

  void createDocument(BuildContext context, WidgetRef ref) async {
    print('Creating document');
    String token = ref.read(userProvider)!.token;
    final navigator = Routemaster.of(context);
    final snackbar = ScaffoldMessenger.of(context);

    final errorModel =
        await ref.read(documentRepositoryProvider).createDocument(token);
    print('awaiting errormodel ');
    if (errorModel.data != null) {
      print('Document created: ${errorModel.data!.id}');
      navigator.push('/document/${errorModel.data.id}');
    } else {
      print('Document creation failed: ${errorModel.error}');
      snackbar.showSnackBar(
        SnackBar(
          content: Text(errorModel.error!),
        ),
      );
    }
  }

  void navigateToDocument(BuildContext context, String documentId) {
    Routemaster.of(context).push('/document/$documentId');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    {
      return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () {
                createDocument(context, ref);
              },
              icon: const Icon(Icons.add),
            ),
            IconButton(
              onPressed: () {
                signOut(ref);
              },
              icon: const Icon(
                Icons.logout,
              ),
              color: kRedColor,
            ),
          ],
        ),
        body: FutureBuilder(
            future: ref.watch(documentRepositoryProvider).getDocuments(
                  ref.watch(userProvider)!.token,
                ),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Loader();
              }
              return Center(
                child: Container(
                  margin: EdgeInsets.only(top: 20),
                  width: 600,
                  child: ListView.builder(
                      itemCount: snapshot.data!.data.length,
                      itemBuilder: (context, index) {
                        DocumentModel document = snapshot.data!.data[index];
                        return InkWell(
                          onTap: () => navigateToDocument(context, document.id),
                          child: SizedBox(
                            height: 50,
                            child: Card(
                              child: Center(
                                child: Text(
                                  document.title,
                                  style: const TextStyle(fontSize: 17),
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                ),
              );
            }),
      );
    }
  }
}
