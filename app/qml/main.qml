/*
* This file is part of Liri.
 *
* Copyright (C) 2015 Michael Spencer <sonrisesoftware@gmail.com>
*               2015 Ricardo Vieira <ricardo.vieira@tecnico.ulisboa.pt>
*
* This program is free software: you can redistribute it and/or modify
* it under the terms of the GNU General Public License as published by
* the Free Software Foundation, either version 3 of the License, or
* (at your option) any later version.
*
* This program is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
* GNU General Public License for more details.
*
* You should have received a copy of the GNU General Public License
* along with this program. If not, see <http://www.gnu.org/licenses/>.
*/

import QtQuick 2.2
import QtQuick.Controls 2.0
import QtQuick.Controls.Material 2.0
import Fluid.Controls 1.0
import Liri.Files.FolderListModel 1.0
import "backend"
import "dialogs"

FluidWindow {
    id: app

    property FolderListSelection selectionManager: folderModel.model.selectionObject()

    title: qsTr("Files")
    width: 800
    height: 800
    visible: true

    initialPage: FolderPage {
        id: folderPage
    }

    Material.primary: Material.Blue
    Material.accent: Material.LightBlue

    function confirmAction(title, text, primaryButton, color) {
        confirmDialog.promise = new Promises.Promise()

        confirmDialog.title = title
        confirmDialog.text = text
        confirmDialog.positiveButtonText = primaryButton

        confirmDialog.show()

        return confirmDialog.promise
    }

    FolderModel {
        id: folderModel

        path: places.locationHome
    }

    SettingsDialog {
        id: settings
    }

    Dialog {
        id: confirmDialog

        property var promise

        onAccepted: promise.resolve()
        onRejected: promise.reject()
    }
}
