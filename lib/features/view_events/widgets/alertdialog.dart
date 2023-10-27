import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller.view_events.dart';

class AddEventPopUp extends GetView<ViewEventController> {
  const AddEventPopUp({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      contentPadding: EdgeInsets.zero,
      content: Container(
        height: MediaQuery.sizeOf(context).height * .5,
        width: MediaQuery.sizeOf(context).width,
        padding: const EdgeInsets.symmetric(
          horizontal: 5,
          vertical: 20,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: Colors.blue,
            width: 2,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 15,
              ),
              child: Obx(
                () => Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${controller.dateEvent.value.day}/${controller.dateEvent.value.month}/${controller.dateEvent.value.year}',
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton(
                      onPressed: () async {
                        await controller.myTimePicker();
                      },
                      child: Text(
                        '- ${controller.timeEvent.value.hour}:${controller.timeEvent.value.minute}',
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 60,
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(horizontal: 10).copyWith(
                    top: 10,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: TextField(
                    controller: controller.titleController,
                    style: const TextStyle(
                      color: Colors.black87,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                    decoration: const InputDecoration(
                      hintText: 'Titre ...',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(left: 20),
                    ),
                  ),
                ),
                Container(
                  height: 60,
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(horizontal: 10).copyWith(
                    top: 10,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: TextField(
                    controller: controller.descriController,
                    style: const TextStyle(
                      color: Colors.black87,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                    decoration: const InputDecoration(
                      hintText: 'Description ...',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(left: 20),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 15,
                  ),
                  height: 60,
                  width: MediaQuery.sizeOf(context).width,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:
                        List.generate(controller.couleurs.length, (index) {
                      Color color = controller.couleurs[index];
                      return Obx(() {
                        bool isSelected =
                            controller.colorEvent.value == color.value;
                        return InkWell(
                          onTap: () {
                            controller.colorEvent(color.value);
                          },
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                                color: color,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  width: 3,
                                  color:
                                      isSelected ? Colors.black : Colors.white,
                                )),
                          ),
                        );
                      });
                    }),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  height: 50,
                  width: 120,
                  margin: const EdgeInsets.symmetric(horizontal: 10).copyWith(
                    top: 10,
                  ),
                  child: MaterialButton(
                      color: Colors.blueAccent,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      onPressed: () async {
                        if (controller.titleController.text.isNotEmpty &&
                            controller.descriController.text.isNotEmpty) {
                          await controller.addOneEvent();
                          Get.back();
                        } else {
                          Get.snackbar(
                            'Erreur',
                            'Veuillez remplir tous les champs',
                            backgroundColor: Colors.red,
                            colorText: Colors.white,
                            snackPosition: SnackPosition.BOTTOM,
                          );
                        }
                      },
                      child: const Text(
                        'Ajouter',
                        style: TextStyle(color: Colors.white),
                      )),
                ),
                Container(
                  height: 50,
                  width: 120,
                  margin: const EdgeInsets.symmetric(horizontal: 10).copyWith(
                    top: 10,
                  ),
                  child: MaterialButton(
                      elevation: 0,
                      color: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      onPressed: () async {
                        controller.titleController.clear();
                        controller.descriController.clear();
                        Get.back();
                      },
                      child: const Text(
                        'Annuler',
                        style: TextStyle(color: Colors.white),
                      )),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
